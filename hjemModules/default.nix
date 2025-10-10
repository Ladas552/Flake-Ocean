{ inputs, meta, ... }:
{
  hjem.users.${meta.user}.rum = {
    programs = {
      bottom = {
        enable = true;
      };
    };
  };
}
