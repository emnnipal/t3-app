/* eslint-disable import/extensions */
// src/pages/api/trpc/[trpc].ts
import { env } from '../../../env/server.mjs';
import { appRouter } from '../../../server/router';
import { createContext } from '../../../server/router/context';

import { createNextApiHandler } from '@trpc/server/adapters/next';

// export API handler
export default createNextApiHandler({
  router: appRouter,
  createContext,
  onError:
    env.NODE_ENV === 'development'
      ? ({ path, error }) => {
          // eslint-disable-next-line no-console
          console.error(`❌ tRPC failed on ${path}: ${error}`);
        }
      : undefined,
});
