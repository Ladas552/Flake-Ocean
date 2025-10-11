topLevel: {
  flake.modules = {
    hjem.bottom = {
      hjem = {
        hjem.users.${topLevel.config.flakes.meta.user}.rum = {
          programs = {
            bottom = {
              enable = true;
            };
          };
        };
      };
    };
  };
}
