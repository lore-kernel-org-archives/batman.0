Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 24 Nov 2011 14:30:59 +0100
Message-ID: <12714486.7khTKuUBZR@sven-laptop.home.narfation.org>
In-Reply-To: <20111124132648.GC6836@lunn.ch>
References: <1322131238-11036-1-git-send-email-sven@narfation.org>
	<1323728.0ybshCSZ9s@sven-laptop.home.narfation.org>
	<20111124132648.GC6836@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3800845.KCkojBcfA9";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Move build compat stuff to
	Makefile
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart3800845.KCkojBcfA9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 24 November 2011 14:26:48 Andrew Lunn wrote:
> > I would be even happier when we also could remove the '#include
> > "compat.h"' from main.h somehow, but I had no good (and working) idea.
> 
> Hi Sven
> 
> Could you build solution using the gcc option:
> 
> -include file
> 
>     Process file as if #include "file" appeared as the first line of
>     the primary source file.
> 
> Pass this when compiling out of tree by appending it to CFLAGS?  The
> hard thing is the ordering. compat.h will be first, before all other
> header files.

No, this doesn't work. I had the same idea, but not only our stuff is build, 
but also some extra kernel stuff. These file will just fail (tested here on 
open-mesh.org with multiple kernel build versions).

Thanks,
	Sven
--nextPart3800845.KCkojBcfA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOzkcTAAoJEF2HCgfBJntGAIIQAL8INfju11uafzHz7E5EQHZz
OQgOvmkl0OBQXcnO18NW2azb/lWggEqMlIEgLKHWYKWkPxBCYbMn2iqzqP7uxjg5
tNKUemou/mO5P24fdL49J3VLPacry0kfxvwJSviNcmMkeHzofzfCwWvnVyO7MSG5
V0KxAzSEePc4IgLwb9uSCZTsXrMx8cKeu3tdDhjxx8Go/rT/vVY5u9SzboDo4Nke
kKXf/nUgXzEsW/oMcyADilQ1eH3ZN0iFA1nFSzALHMZU+YhVVCKRck+nV80DGwGG
dU8gNPsFkGxSA44Zu5hY/KGIsTjZP6OxZeZaQdruPR8UcZ6Q4pS5U+MJ4O4KosRf
QmTkdrzTzBVxwCD78tjWa3FR8ty8Clqp0SKEDIBxGDWLC2Kp3tkoHZuVxJ6ydNfW
bPkiaU/7uMo4gUrzu7LqcgQ8O6YJAWE4C/kYEExU53vDiwtSj8zbkaweSxJD5Wn1
fcXbNRuIgza+qVQrkmWvoGtC22lxE86jrVGJ2kjDYFs/5dIYB15//MO7PNRY3CV7
/XmciLqch0KdpZFij0cR1AOKCs9YzQOaL9Drduujg7b5uVACE75XG2bQCeEPfJVF
/kPGeYlAXG0RIBFWkRVfzinARV1g6kizn0XwcMe5WHx4cO9kHxpzHMQNjse3Smv6
KAjkbY8L9G9Yutlzl/D+
=srlV
-----END PGP SIGNATURE-----

--nextPart3800845.KCkojBcfA9--

