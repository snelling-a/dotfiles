#!/usr/bin/env bash
#
# Generate contribution stats for a GitHub org.
# Usage: ./gh-stats.sh [--since YYYY-MM-DD] [--org ORG] [--user USER]
#

set -euo pipefail

ORG=""
USER=$(gh api user --jq '.login')
SINCE=""

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Generate GitHub contribution stats for an org.

Options:
  --since YYYY-MM-DD   Start date (default: all time)
  --org ORG            GitHub org (required)
  --user USER          GitHub user (default: authenticated user)
  --help               Show this help message
EOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case $1 in
  --help) usage ;;
  --since)
    SINCE="$2"
    shift 2
    ;;
  --org)
    ORG="$2"
    shift 2
    ;;
  --user)
    USER="$2"
    shift 2
    ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
  esac
done

if [[ -z "$ORG" ]]; then
  echo "Error: --org is required"
  usage
fi

DATE_FILTER=""
if [[ -n "$SINCE" ]]; then
  DATE_FILTER="created:>=${SINCE}"
fi

BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

gh_api() {
  local result
  result=$(gh api "$@" 2>&1) || true
  if echo "$result" | grep -q "rate limit"; then
    printf '  %b(rate limited, waiting 60s...)%b\n' "$DIM" "$RESET" >&2
    sleep 60
    result=$(gh api "$@" 2>&1)
  fi
  echo "$result"
}

printf '\n%bGitHub Contribution Stats%b\n' "$BOLD" "$RESET"
if [[ -n "$SINCE" ]]; then
  printf '%bUser: %s | Org: %s | Since: %s%b\n\n' "$DIM" "$USER" "$ORG" "$SINCE" "$RESET"
else
  printf '%bUser: %s | Org: %s | All time%b\n\n' "$DIM" "$USER" "$ORG" "$RESET"
fi

# --- Pull Request Totals ---

printf '%bPull Requests%b\n' "$BOLD" "$RESET"

total=$(gh_api "search/issues?q=type:pr+author:${USER}+org:${ORG}+${DATE_FILTER}&per_page=1" --jq '.total_count')
merged=$(gh_api "search/issues?q=type:pr+author:${USER}+org:${ORG}+${DATE_FILTER}+is:merged&per_page=1" --jq '.total_count')
closed=$(gh_api "search/issues?q=type:pr+author:${USER}+org:${ORG}+${DATE_FILTER}+is:unmerged+is:closed&per_page=1" --jq '.total_count')
open=$(gh_api "search/issues?q=type:pr+author:${USER}+org:${ORG}+${DATE_FILTER}+is:open&per_page=1" --jq '.total_count')
reviewed=$(gh_api "search/issues?q=type:pr+reviewed-by:${USER}+-author:${USER}+org:${ORG}+${DATE_FILTER}&per_page=1" --jq '.total_count')

if [ "$total" -gt 0 ]; then
  merge_rate=$(awk "BEGIN {printf \"%.1f\", ($merged/$total)*100}")
else
  merge_rate="0.0"
fi

if [[ -n "$SINCE" ]]; then
  start_epoch=$(date -j -f "%Y-%m-%d" "$SINCE" "+%s" 2>/dev/null || date -d "$SINCE" "+%s")
else
  first_pr_date=$(gh_api "search/issues?q=type:pr+author:${USER}+org:${ORG}&sort=created&order=asc&per_page=1" --jq '.items[0].created_at // empty')
  if [[ -n "$first_pr_date" ]]; then
    SINCE="${first_pr_date%%T*}"
    start_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$first_pr_date" "+%s" 2>/dev/null || date -d "$first_pr_date" "+%s")
  else
    start_epoch=$(date "+%s")
  fi
fi
now_epoch=$(date "+%s")
weeks=$(awk "BEGIN {printf \"%.1f\", ($now_epoch - $start_epoch) / 604800}")
per_week=$(awk "BEGIN {printf \"%.1f\", $total / $weeks}")

printf "  %-24s %s\n" "Created" "$total"
printf "  %-24s %s (%s%%)\n" "Merged" "$merged" "$merge_rate"
printf "  %-24s %s\n" "Closed (not merged)" "$closed"
printf "  %-24s %s\n" "Open" "$open"
printf "  %-24s %s\n" "Reviewed (others' PRs)" "$reviewed"
printf "  %-24s %s\n" "Avg PRs/week" "$per_week"
printf "\n"

# --- Quarterly Breakdown ---

printf '%bQuarterly Breakdown%b\n' "$BOLD" "$RESET"
printf "  %-22s %10s %10s\n" "Quarter" "Authored" "Reviewed"
printf "  %-22s %10s %10s\n" "----------------------" "----------" "----------"

generate_quarters() {
  local start_year start_month
  IFS='-' read -r start_year start_month _ <<<"$SINCE"
  local today
  today=$(date "+%Y-%m-%d")

  local y=$((start_year))
  local q=$(((10#$start_month - 1) / 3 + 1))

  while true; do
    local q_start_month=$(((q - 1) * 3 + 1))
    local q_end_month=$((q * 3))
    local q_start
    q_start=$(printf "%04d-%02d-01" "$y" "$q_start_month")
    local q_end_day
    case $q_end_month in
    3 | 12) q_end_day=31 ;;
    6 | 9) q_end_day=30 ;;
    esac
    local q_end
    q_end=$(printf "%04d-%02d-%02d" "$y" "$q_end_month" "$q_end_day")

    if [[ "$q_start" < "$SINCE" ]]; then
      q_start="$SINCE"
    fi

    if [[ "$q_start" > "$today" ]]; then
      break
    fi

    if [[ "$q_end" > "$today" ]]; then
      q_end="$today"
    fi

    local label="${y} Q${q}"
    if [[ "$q_start" != $(printf "%04d-%02d-01" "$y" "$q_start_month") ]]; then
      label="${label} (partial)"
    fi

    echo "${q_start}|${q_end}|${label}"

    q=$((q + 1))
    if [ "$q" -gt 4 ]; then
      q=1
      y=$((y + 1))
    fi
  done
}

while IFS='|' read -r q_start q_end label; do
  authored=$(gh_api "search/issues?q=type:pr+author:${USER}+org:${ORG}+created:${q_start}..${q_end}&per_page=1" --jq '.total_count')
  rev=$(gh_api "search/issues?q=type:pr+reviewed-by:${USER}+-author:${USER}+org:${ORG}+created:${q_start}..${q_end}&per_page=1" --jq '.total_count')
  printf "  %-22s %10s %10s\n" "$label" "$authored" "$rev"
  sleep 2
done <<<"$(generate_quarters)"
printf "\n"

# --- Fetch all PRs via GraphQL (single paginated query) ---

sleep 5
printf '  %bFetching PR details...%b' "$DIM" "$RESET"

all_prs=$(gh api graphql --paginate -f query="
query(\$endCursor: String) {
  search(query: \"type:pr author:${USER} org:${ORG} ${DATE_FILTER}\", type: ISSUE, first: 100, after: \$endCursor) {
    pageInfo { hasNextPage endCursor }
    nodes {
      ... on PullRequest {
        repository { name }
        additions
        deletions
        merged
        createdAt
        mergedAt
      }
    }
  }
}" --jq '.data.search.nodes[] | [.repository.name, .additions, .deletions, .merged, .createdAt, .mergedAt // ""] | @tsv') || {
  echo "Error: Failed to fetch PR data from GitHub GraphQL API" >&2
  exit 1
}

printf '\r\033[K'

if [[ -z "$all_prs" ]]; then
  echo "Error: No PR data returned" >&2
  exit 1
fi

# --- PRs by Repository ---

printf '%bPRs by Repository%b\n' "$BOLD" "$RESET"
printf "  %-24s %8s %8s\n" "Repo" "PRs" "%"
printf "  %-24s %8s %8s\n" "------------------------" "--------" "--------"

declare -A repo_counts
while IFS=$'\t' read -r repo _add _del _merged _created _mergedAt; do
  repo_counts[$repo]=$((${repo_counts[$repo]:-0} + 1))
done <<<"$all_prs"

for repo in $(for k in "${!repo_counts[@]}"; do echo "$k ${repo_counts[$k]}"; done | sort -rn -k2 | awk '{print $1}'); do
  count=${repo_counts[$repo]}
  pct=$(awk "BEGIN {printf \"%.1f\", ($count/$total)*100}")
  printf "  %-24s %8s %7s%%\n" "$repo" "$count" "$pct"
done
printf "\n"

# --- Lines Changed ---

printf '%bLines Changed (all merged PRs)%b\n' "$BOLD" "$RESET"
printf "  %-24s %12s %12s %12s\n" "Repo" "Additions" "Deletions" "Net"
printf "  %-24s %12s %12s %12s\n" "------------------------" "------------" "------------" "------------"

declare -A repo_add repo_del
while IFS=$'\t' read -r repo add del is_merged _created _mergedAt; do
  if [[ "$is_merged" == "true" ]]; then
    repo_add[$repo]=$((${repo_add[$repo]:-0} + add))
    repo_del[$repo]=$((${repo_del[$repo]:-0} + del))
  fi
done <<<"$all_prs"

grand_add=0
grand_del=0

for repo in $(for k in "${!repo_counts[@]}"; do echo "$k ${repo_counts[$k]}"; done | sort -rn -k2 | awk '{print $1}'); do
  a=${repo_add[$repo]:-0}
  d=${repo_del[$repo]:-0}
  net=$((a - d))
  grand_add=$((grand_add + a))
  grand_del=$((grand_del + d))
  printf "  %-24s %+12d %12d %+12d\n" "$repo" "$a" "-$d" "$net"
done

grand_net=$((grand_add - grand_del))
printf "  %-24s %12s %12s %12s\n" "------------------------" "------------" "------------" "------------"
printf "  %-24s %+12d %12d %+12d\n" "Total" "$grand_add" "-$grand_del" "$grand_net"
printf "\n"

# --- Time to Merge ---

printf '%bTime to Merge%b\n' "$BOLD" "$RESET"
printf "  %-24s %12s %12s\n" "Repo" "Avg (days)" "Median (days)"
printf "  %-24s %12s %12s\n" "------------------------" "------------" "-------------"

declare -A repo_merge_times
while IFS=$'\t' read -r repo _add _del is_merged created mergedAt; do
  if [[ "$is_merged" == "true" ]] && [[ -n "$mergedAt" ]]; then
    created_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$created" "+%s" 2>/dev/null || date -j -f "%Y-%m-%dT%T%z" "${created%Z}+0000" "+%s" 2>/dev/null || echo "")
    merged_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$mergedAt" "+%s" 2>/dev/null || date -j -f "%Y-%m-%dT%T%z" "${mergedAt%Z}+0000" "+%s" 2>/dev/null || echo "")
    if [[ -n "$created_epoch" ]] && [[ -n "$merged_epoch" ]]; then
      days=$(awk "BEGIN {printf \"%.4f\", ($merged_epoch - $created_epoch) / 86400}")
      repo_merge_times[$repo]="${repo_merge_times[$repo]:-} $days"
    fi
  fi
done <<<"$all_prs"

for repo in $(for k in "${!repo_counts[@]}"; do echo "$k ${repo_counts[$k]}"; done | sort -rn -k2 | awk '{print $1}'); do
  times="${repo_merge_times[$repo]:-}"
  count=$(echo "$times" | wc -w | tr -d ' ')
  [ "$count" -lt 5 ] && continue

  avg=$(echo "$times" | tr ' ' '\n' | awk '{s+=$1; n++} END {if(n>0) printf "%.1f", s/n; else print "N/A"}')
  median=$(echo "$times" | tr ' ' '\n' | sort -n | awk -v n="$count" 'NR==int(n/2)+1 {printf "%.1f", $1}')
  printf "  %-24s %12s %13s\n" "$repo" "$avg" "$median"
done
printf "\n"
