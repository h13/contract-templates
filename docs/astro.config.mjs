// @ts-check
import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';

// https://astro.build/config
export default defineConfig({
  integrations: [mdx()],
  site: 'https://h13.github.io',
  base: '/contract-templates',
  outDir: '../dist-docs',
  publicDir: './public',
});
