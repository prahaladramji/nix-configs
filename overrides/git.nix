{
  programs = {
    gpg.settings = {
      "default-key" = "144AE15C5AF5EF6E903D83357F7BC0427C4E2630";
    };

    git = {
      userName = "Prahalad Ramji";
      userEmail = "prahaladramji@users.noreply.github.com";
      signing.key = "7F7BC0427C4E2630";

      includes = [{
        condition = "gitdir:**/git/safetyculture/";
        contents = {
          user = {
            email = "prahalad.ramji@safetyculture.io";
            signingkey = "F36E578725454606";
          };
        };
      }];
    };
  };
}
