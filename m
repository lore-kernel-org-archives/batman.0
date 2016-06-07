Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jun 2016 10:13:21 +0800
Message-ID: <1850980.QOEIS7I62N@voltaire>
In-Reply-To: <1488113.KCrKATXhSP@bentobox>
References: <20160525152736.9031-1-a@unstable.cc>
 <20160525152736.9031-2-a@unstable.cc> <1488113.KCrKATXhSP@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3508125.hvq7alEAu8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 1/6] batman-adv: split routing API
	data structure in subobjects
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart3508125.hvq7alEAu8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 31, 2016 20:25:16 Sven Eckelmann wrote:
> On Wednesday 25 May 2016 23:27:31 Antonio Quartulli wrote:
> > The routing API data structure contains several function
> > pointers that can easily be grouped together based on the
> > component they work with.
> >
> > Split the API in subobjects in order to improve definition readability.
> >
> > At the same time, remove the "bat_" prefix from the API object and
> > its fields names. These are batman-adv private structs and there is no
> > need to always prepend such prefix, which only makes function invocations
> > much much longer.
> >
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> 
> My eyes don't want to read diffs anymore which only removes bat_ and
> replaces a "_" with a ".". I want more interesting stuff happening in my
> movies^Wpatches
> 
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 2297ba1.

Thanks,
Marek

--nextPart3508125.hvq7alEAu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVi3BAAoJEFNVTo/uthzAa7oIAIPi/PGIgc3lkrVgjwOB94cq
nB9YV1KwLQMFoR+Mi275hqnALZeAD2joKlGk64qIqIpOkvofJ0ZyEjsZEvFLRwGt
ToznEvaIfFcEPOk2NwpYCFGAfG7XHB6aiPqwCmqwlQkJQZXxXlvfySeCrn6AYDbZ
iyL1nX+jFvPhV9ORvnQDV0AfMp2j99gArltSYIki7Qgt8m1EQFFsJ10DR92V+b5o
HFQ+aPKIQb/dhniGd5xIRUBH+iNgHiHbngTAYtLzwX+9qREUPsrbxP1QvwTUyJgv
DC6AvI8LCKvGu/bGKgBnUUTyI/lOhFjuhD2C+YbBOKRNjsiLuu3I21s2X2YwJdI=
=OhrS
-----END PGP SIGNATURE-----

--nextPart3508125.hvq7alEAu8--

