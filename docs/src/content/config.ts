import { defineCollection, z } from 'astro:content';

// 共通スキーマ定義
const baseSchema = z.object({
  id: z.string().optional(),
  title: z.string().optional(),
  type: z.string().optional(),
  version: z.union([z.string(), z.number()]).transform(v => String(v)),
  category: z.string().optional(),
  applicable_to: z.array(z.union([z.string(), z.any()])).optional(),
  created_by: z.string().optional(),
  created_at: z.union([z.string(), z.date()]).transform(v => String(v)).optional(),
  review_frequency: z.string().optional(),
  next_review: z.union([z.string(), z.date()]).transform(v => String(v)).optional(),
  tags: z.array(z.union([z.string(), z.any()])).optional(),
});

// 契約書テンプレートのスキーマ
const contracts = defineCollection({
  type: 'content',
  schema: baseSchema,
});

// 社内規定テンプレートのスキーマ
const regulations = defineCollection({
  type: 'content',
  schema: baseSchema,
});

export const collections = {
  contracts,
  regulations,
};
