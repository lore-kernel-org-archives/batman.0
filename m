Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Nov 2012 20:17:14 +0100
Message-ID: <2584311.tkU79LDNzZ@bentobox>
In-Reply-To: <201211060258.54459.lindner_marek@yahoo.de>
References: <1351982508-16991-1-git-send-email-sven@narfation.org>
 <201211060258.54459.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4400578.oQCKhda3AA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Reorder structs to
	reduce	padding
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart4400578.oQCKhda3AA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 05 November 2012 19:58:54 Marek Lindner wrote:
> On Sunday, November 04, 2012 06:41:48 Sven Eckelmann wrote:
> > -       struct batadv_neigh_node __rcu *router; /* rcu protected pointer
> > */
> > 
> >  #ifdef CONFIG_BATMAN_ADV_DAT
> >  
> >         batadv_dat_addr_t dat_addr;
> >  
> >  #endif
> > 
> > +       uint8_t flags;
> > +       uint8_t gw_flags;
> > +       struct batadv_neigh_node __rcu *router; /* rcu protected pointer
> > */
> 
> Shouldn't we move batadv_dat_addr_t to the end of the struct to achieve the
> smallest possible struct regardless of whether DAT is compiled in or not ?
> Or does it have no effect ?

More or less. It is hard to optimize it for both situation. Just moving to the 
end will not fix the problem because it will create an 1 byte whole which has 
to filled using something else. And optimizing it for all architectures is 
even harder.

But this RFC is not really important. It was just a small fun test of pahole 
for me.

Kind regards,
	Sven
--nextPart4400578.oQCKhda3AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQppE6AAoJEF2HCgfBJntGyJ8P/2Gr+3uyCckoQ7PC/DUHxU6b
Tpql02f+Lt6NSrSaBf5c4Ll3t/7PNPiM4vGZ7sIaNe4f/3Yuh8+J3P1f/Hqk6VQN
wdYoMPUXjtPNPKqKDSMkBOlve6tL0/6xtvNKj9qSXU3qL6lrpXNKIGFGnL/ZcflB
mLLXWoi4xUE1InAZUrUW9Ckg6hCqH8Sf3kbQMjkM910f2AFje5AxgwLNoi0OutJE
ghIzx2AVV6I7zBket1sC1qOnTGuAGFqM82CN4jO2Zxg6KWpL8lZit/k1e9Sdgtxt
lyJdEH/0gLRu9866Wxug58m9HrdXb99BS11Ivz+C/ztFj+eNvKI6oeuwRjw0cIcQ
PemTERg6iFzsVQU1ejjk2IODKERKTfVFfR3eQtEiWZqpVXqvjA4ChxHJ813T3LfC
NaS5ao7DjEuo+/onp4yxBwdERyUHYgonWzTwQ/2NJtyO/M0ElyJWle0sOFUGTRWV
cTwBA9F80TPScsq4eo33TgqFtRpcdm9+KsVVA+2NfsMtmush4jdzVytSREzP1rCd
kJJlvzDQtcFIY6WkCvjZv/+H2IG7IZRL9DqrEJpsXvLl/treG6YfbqilaIMO+Ws2
LjFuLuNoQ8wfBo7bxx/mfSxys8MqzOwf3ASF3uZwNK069RClVOeQlGtuQasJSvg3
5BWXIrIgbkF1GdbR8klw
=i3Uc
-----END PGP SIGNATURE-----

--nextPart4400578.oQCKhda3AA--

