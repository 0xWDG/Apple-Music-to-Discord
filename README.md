# Apple Music to Discord (M2D)
<img width="286" alt="image" src="https://github.com/user-attachments/assets/b9d2e79f-6176-4dc8-86e0-d5f91852d1d5">

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
- [ ] Better error handling

# How to use 

Open `AM2D.xcodeproj` and change `DISCORD_API_KEY.swift` to include your own Discord API key.  
You can create one (for free) at https://discord.com/developers/applications

Be sure to go to `YOUR_APP_NAME` -> `Settings` -> `Rich Presence` -> `Art Assets` and upload the Apple Music logo there (called `am`) or use the logo of your own app.

# Debugging

To see more information about what is happening, 
- You can hold `Option` and click on the `M2D` icon in the menu bar.
- you can open the Console app and search for `nl.wesleydegroot.am2d`.

# Screenshots
<table>
  <tr>
    <th>AM2D</th>
    <td>Discord</td>
  </tr>
  <tr>
    <td>
      <img width="392" alt="image" src="https://github.com/user-attachments/assets/f2734a81-ff49-4b28-979c-2b9cb3cac78a">
    </td>
    <td>
      <img width="230" alt="image" src="https://github.com/0xWDG/Apple-Music-to-Discord/assets/1290461/ee99c9db-2e3d-44d6-af20-351629d67ac8"><br />
      <img width="286" alt="image" src="https://github.com/user-attachments/assets/b9d2e79f-6176-4dc8-86e0-d5f91852d1d5">
    </td>
  </tr>
</table>

# FAQ

<details><summary>Will this app come to the App Store?</summary>Probably not since it does not work with the sandbox being enabled.</details>

# Support / Bug reporting.

Please [create an issue](https://github.com/0xWDG/Apple-Music-to-Discord/issues/new).

# Contact

We can get in touch via [Mastodon](https://mastodon.social/@0xWDG), [Twitter/X](https://twitter.com/0xWDG), [Discord](https://discordapp.com/users/918438083861573692), [Threads](http://threads.net/@0xwdg), [Bluesky](https://bsky.app/profile/0xwdg.bsky.social).

Alternatively you can visit my [Website](https://wesleydegroot.nl)

# Changes

17-NOV-2024:
- Small Improvements.
- Code cleanup.
- Open sourced the project.
- Changed this readme to be more informative.
- Updated screenshots.

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
