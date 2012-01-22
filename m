Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 22 Jan 2012 21:46:50 +0800
References: <1327238532-8433-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1327238532-8433-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201201222146.51275.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: exit on parse error in batctl ll
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, January 22, 2012 21:22:12 Simon Wunderlich wrote:
> If the argument could not be understood, we should not try to
> apply something, but return from the function.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  sys.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/sys.c b/sys.c
> index 9cdccba..ab7d75f 100644
> --- a/sys.c
> +++ b/sys.c
> @@ -221,8 +221,11 @@ int handle_loglevel(char *mesh_iface, int argc, char
> **argv) log_level |= (1 << 1);
>  			else if (strcmp(argv[i], "tt") == 0)
>  				log_level |= (1 << 2);
> -			else
> +			else {
>  				log_level_usage();
> +				free(path_buff);
> +				return EXIT_FAILURE;
> +			}
>  		}
> 
>  		snprintf(str, sizeof(str), "%i", log_level);


Can't we do "goto out" instead of duplicating the free/return. If we do so, 
res should be initialized with EXIT_FAILURE.

Regards,
Marek
