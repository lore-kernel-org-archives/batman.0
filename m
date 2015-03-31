Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 31 Mar 2015 14:18:56 +0200
Message-ID: <2776853.MalcVFtyXS@prime>
In-Reply-To: <20150330212726.46ff30c5@i3.local>
References: <20150330212726.46ff30c5@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5158946.xcg8yieAFZ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: increased default hop penalty
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: felix@freifunk-nrw.de


--nextPart5158946.xcg8yieAFZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

to cite from my original answer:

We did have some discussion on that patch too:

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-June/012155.html

I wrote that patch because we had problems in commercial installations and 
dual radio access points, which were fixed by this patch (as described in the 
mail). I didn't hear any practical problems so far, you are the first one.

I guess its not easy to have a "one value fixes all problems" hop penalty, but 
its at least worth to discuss it - so thank you very much for your input.

Since we got this mail on the mailing list now, I'd like to hear opinions from 
other people and/or communities.

Thanks,
     Simon

On Monday 30 March 2015 21:27:26 Ruben Wisniewski wrote:
> Forwarded private message, on request by Simon.
> 
> On Friday 27 March 2015 16:52:14 Ruben Wisniewski wrote:
> > Hello Simon,
> > 
> > 
> > we just updated our mesh, to the batman-adv-version 2014.4. Now your
> > patch batman-adv: increase default hop penalty[1] is included.
> > 
> > Since we got very large mesh-networks, we have some troubles with your
> > patch, which makes long (needed) pathes unusable, because they TQ drop
> > to lower zero.
> > 
> > Else, we got some old and some new batman-adv versions, this change
> > overloads the old nodes, because their TQ are better, and similiar
> > links over new nodes got ignored.
> > 
> > Else I see no improvement overall, because the usual urban link-wide
> > is about 30-50 meteres, and we got parts of the net where we need 4-5
> > hops to reach the last node. Your Patch seem to limit these pathes to
> > something around 3 hops. So parts of our net are now offline, and the
> > speed overall doesn't seem to be improved.
> > 
> > After these experience I like to ask you, if you mind reverting this
> > patch again. Else we have to work around with resetting to 15 again on
> > boot, which I think is not the prefered solution.
> > 
> > 
> > [1]
> > http://www.open-mesh.org/projects/batman-adv/repository/revisions/7644650b
> > b7 66bd4c7b6be5d97e6b1c3ed93a38d7
> > 
> > 
> > Best regards,
> > 
> > 
> > Ruben

--nextPart5158946.xcg8yieAFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlUakLMACgkQrzg/fFk7axZE2wCfbSKuN3N0dFvpFtXnB+p1iWK8
1pgAoLgvaWAn3IdlGAa6TRpm/w/TGQU5
=O0VW
-----END PGP SIGNATURE-----

--nextPart5158946.xcg8yieAFZ--

