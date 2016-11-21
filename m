Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 Nov 2016 09:31:04 +0100
Message-ID: <1807277.5c8tsCoh5a@bentobox>
In-Reply-To: <CA+6hz4rZyacN_jg74JLg8EWkno2aJEnwJSTwRaw558uE-zAaxA@mail.gmail.com>
References: <1479688779-1328-1-git-send-email-fgao@ikuai8.com>
 <1926952.1nDu9mPud9@bentobox>
 <CA+6hz4rZyacN_jg74JLg8EWkno2aJEnwJSTwRaw558uE-zAaxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1632388.DNzhomgMjo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH net 1/1] net: batman-adv: Treat
	NET_XMIT_CN as transmit successfully
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Feng Gao <gfree.wind@gmail.com>
Cc: mareklindner@neomailbox.ch, Linux Kernel Network Developers <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, "David S. Miller" <davem@davemloft.net>

--nextPart1632388.DNzhomgMjo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 21. November 2016 16:21:52 CET Feng Gao wrote:
> Hi Sven,
> 
> On Mon, Nov 21, 2016 at 4:16 PM, Sven Eckelmann <sven@narfation.org> wrote:
> > On Montag, 21. November 2016 08:39:39 CET fgao@ikuai8.com wrote:
> >> From: Gao Feng <fgao@ikuai8.com>
> >>
> >> The tc could return NET_XMIT_CN as one congestion notification, but
> >> it does not mean the packe is lost. Other modules like ipvlan,
> >
> > s/packe/packet/
> 
> What's this mean?

That there is a minor typo (*t* is missing) and this sed statement (when
applied only to the commit message) would fix it.

David already marked this patch as "Under Review" in his patchwork. So I would
guess that he will accept this patch and not the batman-adv maintainers. And
maybe he will fix this small typo - or maybe not.

Kind regards,
	Sven
--nextPart1632388.DNzhomgMjo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYMrDIAAoJEF2HCgfBJntGkCoP/iLihrMfC5ifPWFVzSmuh8N0
f9f+HlAj+uWYQ8EagEWkvTMEIIE1is0TkuQzA9MjvmYSyqYsHM4qxYUqSlzkGIaQ
qxVlI6ZqhaezStOrLNj9+sP8KW7aZ4xLQKSt/sV6rXY3IUhqFY4F4dwZ1JWOAzM6
73z9iB7mYv9qjCdtvCccRNfeWonGapPlnqaXm+rS/J6angNd8xh3PngXLqEpOYsW
LLW6QfCLi+aYAWk5gCJwjtN8d87jkSNmRe6XUNwP0ZLF5uE5IJPGh+zMtJY+yibr
OlkksDMA8NPbkjgMHlheGexP8KgP53GjcSDukklC6hMm4eR7hMNoWvfAIXeUNHpM
OAaHMmKHC7Ii0fioPq5UWpM7yUZCdYVSImIatTHJsHKSWKmfkiggFoQ819b8axp/
NPay7+JlXm4NsAYwPPiUssidFz8NcqpWabY0XTwI+RfHbUqu2Cg8wf4t+3lbmMzk
kA+Bk93pbicAP6Z5o7dfRYbZUhsW/9ByZhvSFG7RsdFX1eGdTqz1j8Q3SkPlKG0X
n6c5f/xIOkgjdo7ySlrPaGpE4DaAHR4Q3HYLJSlQI74782t8d3hY1okeTk0wtRc+
onuR/LjkqwuSzAER4KuKJavrSRk5+APhTP/wCOrKCvmw7D2AI6opZWwznbj//RkW
1nx88TtceOKfvc3/9tC1
=dj3+
-----END PGP SIGNATURE-----

--nextPart1632388.DNzhomgMjo--

