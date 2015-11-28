Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Nov 2015 09:21:02 +0100
Message-ID: <8889525.bHy7H9IMLu@sven-edge>
In-Reply-To: <56591657.6070401@meshcoding.com>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
 <56591657.6070401@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20997437.X3gSNZdZNA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
	doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>

--nextPart20997437.X3gSNZdZNA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 28 November 2015 10:49:59 Antonio Quartulli wrote:
> Simon Wunderlich:
> > From: Simon Wunderlich <simon@open-mesh.com>
> > 
> > Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> > ---
> > 
> >  net/batman-adv/multicast.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> > index 8abf488..d984eee 100644
> > --- a/net/batman-adv/multicast.c
> > +++ b/net/batman-adv/multicast.c
> > @@ -801,7 +801,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
> > 
> >  	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
> >  	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
> > 
> > +	spin_lock_bh(&bat_priv->tt.commit_lock);
> > 
> >  	batadv_mcast_mla_tt_retract(bat_priv, NULL);
> > 
> > +	spin_unlock_bh(&bat_priv->tt.commit_lock);
> 
> Linus,
> 
> can you please comment as of why batadv_mcast_mla_tt_retract() requires
> to hold the tt.commit_lock ?

Maybe the relevant parts of the Oops can be added to the commit message:

    WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142 batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]()
    [...]
    Call Trace:
     [<ffffffff815fc597>] dump_stack+0x4b/0x64
     [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
     [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]
     [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
     [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]
     [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
     [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
     [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
     [...]

> I see it calls batadv_tt_local_remove() but this does not really
> requires the lock. Maybe you wanted to perform *all* the removes before
> TT could do a commit ? Or is there any other reason?
> 
> Cheers,

mcast.mla_list is protected by tt.commit_lock (see batadv_mcast_mla_tt_add,
batadv_mcast_mla_list_free and batadv_mcast_mla_tt_retract).

Kind regards,
	Sven
--nextPart20997437.X3gSNZdZNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWWWPuAAoJEF2HCgfBJntGQTAP/3SY2ma4b5SJseGjwASe4yvh
stqEs0PHI07Wvs4dhvMqLMwOHr4Wu9lpVoTvVSYQ9l/RWs/SOFrL8Fz5GOC8xFAp
UUNv4X7d9jjElmP1Bzxqbl+oZ3JqKRVJPgwLid36ZEblpkfbu0KXjhjAUAzlNTGi
zGSbaUD9EWB0q0xie9qwYMUBJ6o0ZHUTjzLyxqgbmHpAlOhMQJe+o1nQ6y/BE72f
K6SpIeTcvyFskwo79/koUwsSEyzSe8ITSm0S5OBiIulnZlTx/+GFwlyBu/JyT2Hf
fS6dgL4JGRwc2c2IQnZzojgHjPDQEVLkOIPSZ53JNSOruz8Q1ZCwginc/8yjFMmM
bs9W911yikGOUWn/Fl9bdwdFAXDXFFSVAuU5YAFZwaEsy8k305hJbquDFHwwnq7R
2NNAqpyj9jRrYxtBPsD0yT4wRJQMugQYcHA7U6S5QxNJciBs9y2BLpq9MypLmD07
+kTA6oFnuS6U+GNYAsHQkDYEESH4LwsiEqQZTs0JQemQEsrGho353+gmqiGugF4s
hEYrmUsDuNoP7xiX9eJPLuy3FjN+WC2cfxMWuhfnXDSog4B7Es9+Bl3yi+eKMHel
pt+WvsiPG/v4L0ZTdc9fGxAskIX6YPvH4nYuy0GSUvBf9FcVbgsw7PwlidE1CyfC
fTDR1JmC88Rnl5olzR60
=2GIp
-----END PGP SIGNATURE-----

--nextPart20997437.X3gSNZdZNA--

