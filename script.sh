# !/bin/bash
environment=""
          prodRun=""
          if [[ "${{ inputs.environment }}" == "production" ]]; then
            environment="--environment=production"
            prodRun="--prod"
          fi
          [[ "${{ inputs.environment }}" != "production" && !contains("${{ inputs.branch }}", "dev") ]] && environment="--environment=preview"

          echo contains("${{ inputs.branch }}", "dev")


          vercel pull --yes $environment --token=${{ secrets.vercel_token }}
          vercel build $prodRun --token=${{ secrets.vercel_token }}
          vercel deploy --prebuilt $prodRun --token=${{ secrets.vercel_token }} -m githubCommitRef=${{ inputs.branch }}