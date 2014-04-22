$addToUserPath = @(
  "C:\Program Files (x86)\Git\bin",
  "C:\Program Files\Sublime Text 3",
  "C:\Program Files\SourceGear\Common\DiffMerge"
)

foreach ($pathItem in $addToUserPath) {
  if (test-path $pathItem){
    $env:PATH += ";$pathItem"
  }
}
