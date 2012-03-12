Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Mar 2012 13:16:43 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E9D@saturn3.aculab.com>
In-Reply-To: <1331419491-21333-4-git-send-email-lindner_marek@yahoo.de>
From: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Use {} braces consistent
	on the arms of a statement
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
To: Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

=20
> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 01b66d4..7f8e158 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -237,8 +237,9 @@ int window_protected(struct bat_priv=20
> *bat_priv, int32_t seq_num_diff,
>  				"old packet received, start
protection\n");
> =20
>  			return 0;
> -		} else
> +		} else {
>  			return 1;
> +		}
>  	}
>  	return 0;
>  }

Doesn't this one fail on the "don't use 'else' after return/break" ?
Also look like it would read better if the condition (not quoted)
were inverted and the 'return 1' put first.

	David


