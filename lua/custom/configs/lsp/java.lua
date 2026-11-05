return {
  jdtls = {
    filetypes = { "java" },
    root_markers = { "gradlew", "build.gradle", "pom.xml", ".git" },
    cmd = {
      "jdtls",
      "-data",
      vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
    },
  },
}
