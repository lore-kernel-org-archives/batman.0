Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Dec 2011 15:36:26 +0800
References: <1322835344-23077-1-git-send-email-martin@hundeboll.net>
	<1322836651-25134-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1322836651-25134-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201112031536.26477.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Move is_out_of_time() to
	main.c for general use
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

On Friday, December 02, 2011 22:37:31 Martin Hundeb=C3=B8ll wrote:
> Both translation tables and network coding use timeouts to do house
> keeping, so we might as well share the function used to compare a
> timestamp+timeout with current time.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  main.c              |    5 +++++
>  main.h              |    1 +
>  translation-table.c |    8 --------
>  3 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/main.c b/main.c
> index 71b56cf..0930bb4 100644
> --- a/main.c
> +++ b/main.c
> @@ -172,6 +172,11 @@ int is_my_mac(const uint8_t *addr)
>         return 0;
>  }
> =20
> +bool is_out_of_time(unsigned long timestamp, unsigned long timeout)
> +{
> +       return time_is_before_jiffies(timestamp +
> msecs_to_jiffies(timeout));=20
> +}

Since it is a simple one-liner you could make it a define or at least stati=
c=20
inline (in main.h).

How about a more descriptive name like "reached_timeout()" or=20
"has_timed_out()" ? We could use it in other parts of the code too.

You might also want to add a few words about the fact that you did not only=
=20
move the function but also changed time_after() to time_is_before_jiffies()=
 at=20
the same time.

Regards,
Marek
