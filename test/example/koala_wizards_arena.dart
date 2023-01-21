main(){

  const wizardsArenaQrURI = 'wc:38d5743f87264253cb529e6eb98c5c51a4c3782598c098d27b762d6e5806399a@2?relay-protocol=irn&symKey=b569599ad1a1e50c01403cead1e41c5e826c74e60a335ba46af75f01f1d895fa';
  Uri uri = Uri.parse(wizardsArenaQrURI);
  print('uri = $uri');
  print('uri.scheme = ${uri.scheme}');

}