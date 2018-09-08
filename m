Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 08 Sep 2018 19:11:09 +0200
Message-ID: <11216967.y5cQ9vbesN@sven-edge>
In-Reply-To: <20180907095958.30946-7-mareklindner@neomailbox.ch>
References: <20180907095958.30946-1-mareklindner@neomailbox.ch>
 <20180907095958.30946-7-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2973985.nLNjUtWez9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2973985.nLNjUtWez9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 7. September 2018 11:59:57 CEST Marek Lindner wrote:
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---

Most patches in the patchset have quite long patch summary phrase [1]. And 
this one here (and the patch 3)  doesn't have a commit message at all.

Wouldn't it be better to have some actual message and a more brief+precise 
subject

    batman-adv: ELP - Fall back to tpmeter for throughput estimation

    ... when nothing works ... blablabla .. better than nothing ... blublub
    under following conditions ...
    done every ...
    more text here
    ...

(actual info has to be added and the subject can be better then the example 
one here).

Kind regards,
	Sven

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#the-canonical-patch-format
--nextPart2973985.nLNjUtWez9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluUAq0ACgkQXYcKB8Em
e0YI+hAAxxuT6PJ6H9QgozuSsIRvkBXsB/9ef1GH8AD6UNTUxo6mr3LYQTPde8iJ
+Gp1VartXvGOZ83ohQImFY2s1MH11nOvZbGgbb9rKwwe2kYEn25ygrsFtWRRZDGc
MpDNgYcOX6NNiG6YpoSZu8iJBmgeD2sPrZbehCpDDdpH3hbF/RG+w6j+AYiBlLbh
QmkW6WsprUJkvOXRB/28CseE+v6dGQejTvYz9qAvRywxgMR0Hy3yS4qBuDWFWl6R
oy6+YtSRBtqrQea2pEA6wIQeGG+reiDQi+3xfOzdeS9ZhWSHykObq+ewhmM8aTfA
/Lb3z/EhbKKgYKzjubprp1nsZKbJd/f+Hhh6DV/7M31bWVQPMNPWYfcRK+PYUcxj
7MmoPYQorRW6r9tkHwu8mocLMNSBzNTSmnstO+nARb026h3PmseS5HEyhCR9u9Sm
HVhW16vZcA4Nkjhxa0ezJoBcUbWgewcOYQ8g3oQcUrjU6k+NNR3f6dhnhtDy3M9K
at/rauN8Ne74OD4IHR6rRC9L1FCjJKOxl96Nes7ZezkmWnGZrKSAsZ7k8aOGCtVX
gRCSvUu3CMhRrAHB4sjcQOFlAz3KySwan/TgO7esgviz+4Aodf7EXROguSuA3MGV
WCagpGWaQHbMZDcgEtly5henjw+mT7I0YElKh9UV4wdstrYpPlo=
=Kzwx
-----END PGP SIGNATURE-----

--nextPart2973985.nLNjUtWez9--



