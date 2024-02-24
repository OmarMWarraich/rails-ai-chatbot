require('esbuild').build({
    entryPoints: ['app/javascript/application.js'],
    bundle: true,
    outdir: 'app/assets/builds',
    sourcemap: true,
    external: ['@hotwired/turbo-rails', 'controllers'],
    }).catch(() => process.exit(1)) 