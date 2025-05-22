'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js_1.part.js": "aaa9c0e783e7e89151c5b9795ffc9c22",
"icons/Icon-maskable-192.png": "84bdcbfd4897026ca51386fc38353210",
"icons/Icon-192.png": "84bdcbfd4897026ca51386fc38353210",
"icons/Icon-maskable-512.png": "7665b65818eaa830a22859a002beb269",
"icons/Icon-512.png": "7665b65818eaa830a22859a002beb269",
"assets/fonts/MaterialIcons-Regular.otf": "1c553262513bbc734a9bc98293f459eb",
"assets/AssetManifest.bin.json": "82207e876983b0076fa9c98ecaec46b2",
"assets/AssetManifest.bin": "5dda1d053c6fc365aec80c5db7dd3997",
"assets/AssetManifest.json": "18201971e0ee4a64f07e084d38291184",
"assets/assets/projects/orienteering_2.jpg": "2bc6c473f172f671e875bee101a53e14",
"assets/assets/projects/neogate.jpg": "925523f12133527444b8129633ddaccb",
"assets/assets/projects/neogate_2.jpg": "b2377d28cb68277a9515dee978248dfd",
"assets/assets/projects/plant_whisperer_2.jpg": "ef21c99012e60dbcec1a679516de1fbd",
"assets/assets/projects/forgather_2.jpg": "e4b30214a350beff61a6e60ad3c47f91",
"assets/assets/projects/plant_whisperer.jpg": "07a1bf6d4528b9ed92d9fc350c7d4cec",
"assets/assets/projects/orienteering.jpg": "634b377f53b3a3091ea10d507ab326d6",
"assets/assets/projects/forgather.jpg": "77059ae74317e04c37677959566c5ae3",
"assets/assets/interests/photo.png": "24e6d440f877f981b498541a914723c9",
"assets/assets/interests/coffee.png": "e7564a6181b987e71c764b40fe60d3b2",
"assets/assets/interests/electronics.png": "dcc259f564ce31638c164f407898fec4",
"assets/assets/interests/music.png": "d8532f236e69fc431103ffc0231a6072",
"assets/assets/minecraft/deepslate_lapis_lazuli_ore.png": "7fbd7e6f60dba27d2fa8df66f2638c72",
"assets/assets/minecraft/redstone.png": "1a1edaa046f664da8d52ce72215e278a",
"assets/assets/minecraft/iron_ore.png": "e030734f57ba1cc14318c09cc637c0d8",
"assets/assets/minecraft/emerald_ore.png": "817945c0acecb1c8cd04662965273a05",
"assets/assets/minecraft/gold_ore.png": "467adf3e01f8cd15a4579a47b9ee715f",
"assets/assets/minecraft/oak_log.png": "94d5dd09b828ed76cfb3f5a3303aab17",
"assets/assets/minecraft/lapis_lazuli_ore.png": "7f469b98d05eb503e9f24f93e7a9d95b",
"assets/assets/minecraft/stone.png": "2ec21c760be82ae32d08479128c2cd2a",
"assets/assets/minecraft/coal_ore.png": "49dcf62a503479b2a86443cf165cf3c2",
"assets/assets/minecraft/deepslate.png": "00eca4ec5be4335bd26304b7603d769f",
"assets/assets/minecraft/redstone_ore.png": "b0fcdd12c5d8c1f382c68db6c4b2f03d",
"assets/assets/minecraft/deepslate_gold_ore.png": "d39285438de547ce40686b56d6258003",
"assets/assets/minecraft/deepslate_diamond_ore.png": "3c7abffc3658302b2bd0f7f68ed356d7",
"assets/assets/minecraft/enchantment_table.png": "444c882535439f28b79de890c00aacce",
"assets/assets/minecraft/grass_block.png": "e13e09a91df0e19629e42c2445501a3a",
"assets/assets/minecraft/bedrock.png": "90daac64987ff3732cf16fd6638d6857",
"assets/assets/minecraft/sky.png": "2d66cda64b0be774ea8991b8d5a70f13",
"assets/assets/minecraft/oak_leaves.png": "a6dcaf71a3bf1b989289fad7bc7901c9",
"assets/assets/minecraft/diamond_ore.png": "38f29fb0552d37d73fea0035999ac8cf",
"assets/assets/minecraft/copper_ore.png": "065dcde9d6878845284bc41f593a8d23",
"assets/assets/minecraft/deepslate_redstone_ore.png": "3ed3885c0f84a8657e9473c83f479eb8",
"assets/assets/minecraft/deepslate_iron_ore.png": "8a321c6fba525b0c2dc90886bab0964c",
"assets/assets/minecraft/deepslate_emerald_ore.png": "d5da07a25db467b461f72ff28babcd30",
"assets/assets/minecraft/book.png": "c3088c44fa49b68d5bd20a7dee60e55f",
"assets/assets/minecraft/head.png": "b496455342133ca2ddf04a615c38938c",
"assets/assets/minecraft/dirt_block.png": "d2e1f274e2e2aded9e19041afeb97991",
"assets/assets/photo.jpg": "f0e711c24a0d00fb02a1fd0ee95ee35c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "26c54921606fa7981033522d1b880f67",
"main.dart.js": "566646fa6ca1e4a6ee19f61d698b01ff",
"manifest.json": "578563658902fb984933506e1312b830",
"version.json": "009c9e65172e010890f7f65fde438006",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"flutter_bootstrap.js": "3779af60c9533eed7c02baf2176e9a19",
"favicon.png": "c9dd1cf032fe8b3a123836bc2b5200be",
"index.html": "b4b4c8b63ce04a7db4bee03d0ee7c06a",
"/": "b4b4c8b63ce04a7db4bee03d0ee7c06a",
"flutter.js": "76f08d47ff9f5715220992f993002504"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
