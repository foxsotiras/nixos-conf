{ ... }:

{
  programs.git = {
    enable = true;

    includes = [
      {
        # This is configuration for git. Change it to yours.
        contents = {
          user = {
            name = "Johnny Fox";
            email = "fox.sotiras.work@gmail.com";
            signingKey = "~/.ssh/github_signin.pub";
          };
          init.defaultBranch = "master";
          commit.gpgsign = true;
          tag.gpgsign = true;
          gpg = {
            format = "ssh";
            ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          };
        };
      }
    ];
  };
}
