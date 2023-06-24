# Strategy ZoneTrade

[![Status][gha-image-check-master]][gha-link-check-master]
[![Status][gha-image-compile-master]][gha-link-compile-master]
[![Channel][tg-channel-image]][tg-channel-link]
[![Discuss][gh-discuss-badge]][gh-discuss-link]
[![License][license-image]][license-link]

Implements ZoneTrade Strategy.

## Description

Strategy allows you to choose two indicators on which signals are based on.

If both indicators are increasing, it indicates a green zone (buy signal).
If both indicators are decreasing, it indicates a red zone (sell signal).
If both indicators have different signals, it signifies a grey zone (neutral signal).

The purpose of categorizing the market into different zones is to help traders
identify the current market conditions and potentially make trading decisions
based on the color-coded zones. The green zone might indicate a favorable
bullish momentum, while the red zone might suggest a bearish momentum. The grey
zone could represent a period of uncertainty or transition in the market.

This strategy is based on the idea of BW-ZoneTrade indicator proposed by Bill Williams.

The difference is that BW-ZoneTrade indicator is usually calculated
by AO (for current market momentum) and AC (for price acceleration) indicators,
whereas this strategy is more flexible by allowing any other indicators
(including AC and AO).

## Dependencies

| Tag      | Framework |
|:--------:|:---------:|
| v2.000   | v3.000.1  |

<!-- Named links -->

[gh-discuss-badge]: https://img.shields.io/badge/Discussions-Q&A-blue.svg?logo=github
[gh-discuss-link]: https://github.com/EA31337/EA31337-Strategies/discussions

[gha-link-check-master]: https://github.com/EA31337/Strategy-ZoneTrade/actions?query=workflow:Check+branch%3Amaster
[gha-image-check-master]: https://github.com/EA31337/Strategy-ZoneTrade/workflows/Check/badge.svg?branch=master
[gha-link-compile-master]: https://github.com/EA31337/Strategy-ZoneTrade/actions?query=workflow:Compile+branch%3Amaster
[gha-image-compile-master]: https://github.com/EA31337/Strategy-ZoneTrade/workflows/Compile/badge.svg?branch=master

[tg-channel-image]: https://img.shields.io/badge/Telegram-join-0088CC.svg?logo=telegram
[tg-channel-link]: https://t.me/EA31337

[license-image]: https://img.shields.io/github/license/EA31337/EA31337-Strategies.svg
[license-link]: https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3)
