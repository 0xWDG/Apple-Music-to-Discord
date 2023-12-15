# Apple Music to Discord (public beta)
<img width="305" alt="image" src="https://github.com/0xWDG/Apple-Music-to-Discord/assets/1290461/f4c404da-7d1a-4a54-b281-cf3aaa63413e"><br />
Display your Apple Music play status to Discord.

<a href='https://github.com/0xWDG/Apple-Music-to-Discord/raw/main/AM2D.zip'>
  <img alt="Download" src="https://img.shields.io/badge/Download-Beta-6bbee8?style=for-the-badge">
 </a>
 
# Functions finished
- [x] Read current song info from Apple Music
- [x] Update Discord presence to show information
- [x] Fetch album art
- [ ] Support Indicator for Stopped/Playing/Pause status
- [x] Remove requirement to start Discord first (retry connecting when failed)
- [x] Check if Apple Music has started, for initial song info (now the song info will be fetched when connected to Discord)
- [x] Make `<` (back), `=` (pause), `>` (next) buttons work.
- [x] ~~Remove spinner if loading of artwork fails.~~ Spinner now have the same size as the artwork, and will hide if failed.
- [ ] Support auto start at login

# How to use 
> **Notice**:\
> Since this is a beta product, follow the steps below carefully to use this. this requirement will be removed/fixed in a future version

1. ~~Open Discord~~
2. ~~Open Apple Music~~
3. ~~Open AM2D.app~~
4. ~~Wait and see your status being updated~~

**Update (15-DEC-2023):** This should be fixed, this how to use stays until i'm sure it is fixed.

# Screenshots

<table>
  <tr>
    <th>AM2D</th>
    <td>Discord</td>
  </tr>
  <tr>
    <td>
      <img width="392" alt="image" src="https://github.com/0xWDG/Apple-Music-to-Discord/assets/1290461/4099433c-78bc-4643-bc0d-2de98061feea">      
    </td>
    <td>
      <img width="230" alt="image" src="https://github.com/0xWDG/Apple-Music-to-Discord/assets/1290461/ee99c9db-2e3d-44d6-af20-351629d67ac8"><br />
      <img width="305" alt="image" src="https://github.com/0xWDG/Apple-Music-to-Discord/assets/1290461/f4c404da-7d1a-4a54-b281-cf3aaa63413e">
    </td>
  </tr>
</table>

# FAQ

<details><summary>Will this app come to the App Store?</summary>Probably not since it does not work with the sandbox being enabled.</details>

# Support / Bug reporting.

Please [create an issue](https://github.com/0xWDG/Apple-Music-to-Discord/issues/new).

# Contact

We can get in touch via [Twitter/X](https://twitter.com/0xWDG), [Discord](https://discordapp.com/users/918438083861573692), [Mastodon](https://iosdev.space/@0xWDG), [Threads](http://threads.net/@0xwdg), [Bluesky](https://bsky.app/profile/0xwdg.bsky.social).

Alternatively you can visit my [Website](https://wesleydegroot.nl) or my [Blog](https://wdg.codes)

# Changes

<details>
  <summary>15-DEC-2023</summary>
  &bull; Play/Pause, Previous and Next buttons are working<br />
  &bull; Fixes remaining time being incorrectly after switching to a new song<br>
  &bull; Updated GUI a little bit.<br>
  <strong>Revision 1</strong><br>
  &bull; Retry if Discord is not found.<br>
  &bull; Check if Apple Music is running.<br>
  &bull; Remove requirement to start everything in a particulair order.
</details>
<details><summary>05-DEC-2023</summary>&bull; Initial version.</details>
