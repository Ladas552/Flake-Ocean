{ self, ... }:
{
  flake.modules.hjem.mpd =
    { config, pkgs, ... }:
    {
      packages = with pkgs; [
        mpc
        self.packages.${pkgs.stdenv.hostPlatform.system}.musnow
      ];
      # Todo. add keybinds for skiping to next album with `[` & `]` when it's added to rmpc
      xdg.config.files."rmpc/config.ron".text = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              address: "127.0.0.1:6600",
              theme: Some("bash"),
              cache_dir: "~/.cache/rmpc/",
              on_song_change: None,
              volume_step: 2,
              scrolloff: 2,
              enable_mouse: true,
              wrap_navigation: true,
              status_update_interval_ms: 1000,
              select_current_song_on_change: true,
              album_art: (
                  method: Kitty,
              ),
              keybinds: (
                  global: {
                      "1":       QueueTab,
                      "2":       DirectoriesTab,
                      "3":       ArtistsTab,
                      "4":       AlbumsTab,
                      "5":       PlaylistsTab,
                      "6":       SearchTab,
                      "7":       ShowOutputs,
                      "?":       ShowHelp,
                      ":":       CommandMode,
                      "Q":       Stop,
                      "c":       ToggleSingle,
                      "<Tab>":   NextTab,
                      "<S-Tab>": PreviousTab,
                      "q":       Quit,
                      "n":       NextTrack,
                      "N":       PreviousTrack,
                      "b":       PreviousTrack,
                      ".":       SeekForward,
                      ",":       SeekBack,
                      "k":       VolumeDown,
                      "l":       VolumeUp,
                      "r":       ToggleRandom,
                      "C":       ToggleConsume,
                      "p":       TogglePause,
                      "R":       ToggleRepeat,
                  },
                  navigation: {
                      "<C-u>":   UpHalf,
                      "=":       NextResult,
                      "-":       PreviousResult,
                      "<Space>":       Add,
                      "A":       AddAll,
                      "g":       Top,
                      "G":       Bottom,
                      "<CR>":    Confirm,
                      "i":       FocusInput,
                      "J":       MoveDown,
                      "<Up>":       Up,
                      "<Down>":       Down,
                      "<Left>":       Left,
                      "<Right>":       Right,
                      "<C-d>":   DownHalf,
                      "/":       EnterSearch,
                      "<C-c>":   Close,
                      "<Esc>":   Close,
                      "K":       MoveUp,
                      "D":       Delete,
                  },
                  queue: {
                      "D":       DeleteAll,
                      "<CR>":    Play,
                      "<C-s>":   Save,
                      "a":       AddToPlaylist,
                      "d":       Delete,
                  },
              ),
          )
        '';

      xdg.config.files."rmpc/themes/bash.ron" = {
        recursive = true;
        text = # ron
          ''
            #![enable(implicit_some)]
            #![enable(unwrap_newtypes)]
            #![enable(unwrap_variant_newtypes)]
            (
                album_art_position: Right,
                album_art_width_percent: 40,
                default_album_art_path: None,
                show_song_table_header: true,
                draw_borders: true,
                browser_column_widths: [10, 38, 42],
                background_color: None,
                text_color: None,
                header_background_color: None,
                modal_background_color: None,
                tab_bar: (
                    enabled: false,
                    active_style: (fg: "black", bg: "blue", modifiers: "Bold"),
                    inactive_style: (),
                ),
                highlighted_item_style: (fg: "blue", modifiers: "Bold"),
                current_item_style: (fg: "black", bg: "blue", modifiers: "Bold"),
                borders_style: (fg: "blue"),
                highlight_border_style: (fg: "blue"),
                symbols: (song: "", dir: "", marker: "M"),
                progress_bar: (
                    symbols: ["-", "C", "•"],
                    track_style: (fg: "white"),
                    elapsed_style: (fg: "green"),
                    thumb_style: (fg: "green", bg: "#1e2030"),
                ),
                scrollbar: (
                    symbols: ["│", "█", "▲", "▼"],
                    track_style: (),
                    ends_style: (),
                    thumb_style: (fg: "blue"),
                ),
                song_table_format: [
                    (
                        prop: (kind: Property(Title),
                            default: (kind: Text("Unknown"))
                        ),
                        width_percent: 45,
                    ),
                    (
                        prop: (kind: Property(Artist),
                            default: (kind: Text("Unknown"))
                        ),
                        width_percent: 45,
                    ),
                    (
                        prop: (kind: Property(Duration),
                            default: (kind: Text("-"))
                        ),
                        width_percent: 10,
                        alignment: Right,
                    ),
                ],
                header: (
                    rows: [
                        (
                            left: [
                                (kind: Property(Status(Elapsed))),
                                (kind: Text(" / ")),
                                (kind: Property(Status(Duration))),
                            ],
                            center: [
                                (
                                    kind: Property(Widget(States(
                                        active_style: (fg: "white", modifiers: "Bold"),
                                        separator_style: (fg: "white")))
                                    ),
                                    style: (fg: "dark_gray")
                                ),
                            ],
                            right: [
                                (kind: Property(Widget(Volume)), style: (fg: "red"))
                            ]
                        ),
                    ],
                ),
                browser_song_format: [
                    (
                        kind: Group([
                            (kind: Property(Track)),
                            (kind: Text(" ")),
                        ])
                    ),
                    (
                        kind: Group([
                            (kind: Property(Artist)),
                            (kind: Text(" - ")),
                            (kind: Property(Title)),
                        ]),
                        default: (kind: Property(Filename))
                    ),
                ],
            )
          '';
      };
      services.mpdris2.enable = true;

      services.mpd = {
        enable = true;
        musicDirectory = config.xdg.userDirs.music.directory;
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "Pipewire Sounds Server"
          }
          audio_output {
            type               "fifo"
            name               "toggle_visualizer"
            path               "/tmp/mpd.fifo"
            format             "44100:16:2"
          }
          auto_update "yes"
          metadata_to_use "artist, album, title, track, name, genre, date, composer, performer, disc, comment"
        '';
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/share/mpd" ];
    };
}
