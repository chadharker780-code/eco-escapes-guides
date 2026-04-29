# Eco Escapes Guides

Hosted visual guides and reference pages for Eco Escapes.

**Live site:** `https://chadharker780-code.github.io/eco-escapes-guides/` (will migrate to `guides.ecoescape.com` once Cloudflare Pages is wired up).

## Folder structure

| Folder | Audience | Examples |
|--------|----------|----------|
| `team/` | Internal team reference | Drive Operating Guide, SOP visualizations, process maps |
| `guests/` | Guest-facing pages | Pool rules, hot tub start-up, sauna safety, check-in walkthroughs |
| `owners/` | Property owners | Onboarding walkthrough, owner portal guide |
| `leads/` | Prospects / sales | Pitch one-pagers, ManyChat save-trigger destinations, investor teasers |
| `_assets/` | Shared resources | Fonts, images, shared CSS (none today) |

URL pattern: `https://guides.ecoescape.com/<folder>/<slug>`

## Publishing a new guide

1. Generate the HTML using the visual-explainer skill (Claude Code):
   ```
   /visual-explainer:generate-web-diagram   # for static reference guides
   /visual-explainer:generate-slides        # for pitch decks
   /visual-explainer:generate-visual-plan   # for process walkthroughs
   ```
2. Copy the file into the correct audience folder using kebab-case:
   ```
   ./publish.sh <audience> <slug> <path-to-html>
   ```
   Example: `./publish.sh team launch-pipeline ~/.agent/diagrams/pipeline.html`
3. Commit and push:
   ```
   git add . && git commit -m "add: <slug>" && git push
   ```
4. Live in ~60s at `https://guides.ecoescape.com/<audience>/<slug>`.

## When to split into a second repo

This repo is **public** to enable free GitHub Pages and reduce friction. Acceptable contents:
- Folder structures, process maps, team first names
- Guest-facing safety/policy pages
- Marketing one-pagers
- Public-OK pitch material

Migrate to a private second repo (`eco-escapes-internal`) when a guide contains:
- Specific financials (revenue, fees, margins)
- Client names + property addresses together
- API keys, credentials, internal system internals
- Owner-specific contracts or statements

Private repos can still use Cloudflare Pages on free tier (no GitHub Pro needed).

## Cloudflare Pages migration (deferred)

Today: GitHub Pages serves the site at `chadharker780-code.github.io/eco-escapes-guides/`.

Next step (~10 min, browser required):
1. Cloudflare dashboard → Workers & Pages → Create → Connect to GitHub → select this repo
2. Build settings: framework = none, build command = (empty), output directory = `/` (root)
3. Custom domains → Add `guides.ecoescape.com` → Cloudflare auto-creates the CNAME (DNS already in Cloudflare)
4. Update this README's live-site link

GitHub Pages keeps working in parallel forever; Cloudflare Pages just becomes the canonical URL.

## Generator workflow reference

The visual-explainer plugin is installed at `~/.claude/plugins/marketplaces/visual-explainer-marketplace/plugins/visual-explainer/`. Brand palette for Eco Escapes guides:

| Color | Hex | Usage |
|-------|-----|-------|
| Forest | `#3F5E4F` | Primary, hero cards, headings |
| Sage | `#7BA68B` | Secondary, success outcomes, accents |
| Cream | `#FAF7F0` | Background, light surfaces |
| Terracotta | `#C9846B` | STOP banners, callouts, warnings |
| Warm | `#C9B888` | Archive, tertiary accents |

Typography pairing (default for team-facing): Bricolage Grotesque (body) + Fragment Mono (mono).
