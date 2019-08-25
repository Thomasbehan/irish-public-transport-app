class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;

}

final sampleItems = <IntroItem>[
  new IntroItem(title: 'View Your Favourites', category: 'FAVOURITES', imageUrl: 'assets/fav.jpg',),
  new IntroItem(title: 'View All Available Routes', category: 'ROUTES', imageUrl: 'assets/1.jpg',),
  new IntroItem(title: 'View All Stops & Terminals', category: 'STOPS', imageUrl: 'assets/2.jpg',),
  new IntroItem(title: 'Customise Your Experience', category: 'SETTINGS', imageUrl: 'assets/settings.jpg',),
];