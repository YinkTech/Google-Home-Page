name: Linters

on: pull_request

env:
  FORCE_COLOR: 1

jobs:
  lighthouse:
    name: Lighthouse
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v1
        with:
          node-version: "12.x"
      - name: Setup Lighthouse
        run: npm install -g @lhci/cli@0.4.x
      - name: Lighthouse Report
        run: lhci autorun --upload.target=temporary-public-storage --collect.staticDistDir=.
  webhint:
    name: Webhint
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v1
        with:
          node-version: "12.x"
      - name: Setup Webhint
        run: |
          npm install --save-dev hint@6.0.x
          [ -f .hintrc ] || wget https://raw.githubusercontent.com/microverseinc/linters-config/master/html-css/.hintrc
      - name: Webhint Report
        run: npx hint --telemetry=off .
  stylelint:
    name: Stylelint
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v1
        with:
          node-version: "12.x"
      - name: Setup Stylelint
        run: |
          npm install --save-dev stylelint@13.3.x stylelint-scss@3.17.x stylelint-config-standard@20.0.x stylelint-csstree-validator
          [ -f .stylelintrc.json ] || wget https://raw.githubusercontent.com/microverseinc/linters-config/master/html-css/.stylelintrc.json
      - name: Stylelint Report
        run: npx stylelint "**/*.{css,scss}"