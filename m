Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 11 Feb 2016 12:08:25 +0100
Message-ID: <3200137.NDelIOaaur@prime>
In-Reply-To: <OF08AE6344.F52C14B1-ONC1257F56.002E1241-C1257F56.0033308C@phoenixcontact.com>
References: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
 <OFCA66B6A0.8D0726B0-ONC1257F54.00240C7B-C1257F54.0026962A@phoenixcontact.com>
 <OF08AE6344.F52C14B1-ONC1257F56.002E1241-C1257F56.0033308C@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2642916.lZ8J9AehcY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Looping unicast packets when using
	BLA
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>

--nextPart2642916.lZ8J9AehcY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Andreas,

On Thursday 11 February 2016 10:19:07 Andreas Pape wrote:
> Hi,
> 
> I want to give a short feedback concerning my attempt to use
> batman-adv-2016.0 instead of to older version I used first.
> 
> Unfortunately, using batman-adv-2016.0 does not solve my problem. I can
> still see claim frames sent by the mesh gateways into the common backbone
> network for MAC addresses out of the common backbone network itself. I
> enabled again both bla and dat support. Furthermore I have also still
> problems with DAT, because there are multiple ARP replies visible in the
> backbone network coming out of the mesh.
> 
> That reminds me that I have forgotten to mention in my earlier mail, that
> I did not test with the original batman-adv-2014.4.0 first but with a
> version having the patch applied I sent to the mailing list in March last
> year concerning possible fixes for dat in bla setups. If I remember it
> correctly I think there were two main issues in batman-adv-2014.4.0 when
> using dat in combination with bla:
> 1.Broadcast ARP requests from the backbone network are handled by each
> gateway, leading to multiple dat adress resoultions in parallel.

That shouldn't be a problem on its own.

> 2. As dat uses tunneling of broadcasts in special batman-adv unicast
> frames, the current bla code does not seem to prevent these broadcasts
> from reaching the backone network as it is done for normal broadcast
> coming from the mesh and heading for the backbone.
> Both effects together lead to a multiplication of arp requests and
> replies. My patch of last year tried to address this.

Hm, I see. I just checked the code and it seems we fixed this issue for speedy 
join in the mean time (affecting TT), but for bla the problem is still 
present.

Wouldn't it be sufficient to add something like a check for backbones ( 
batadv_bla_is_backbone_gw) into batadv_recv_unicast_packet() and drop packets 
if they came from the same backbone?

I have found your patch from last year. Would you like to rebase/split your 
patch to address the remaining issues? That would help us a lot. Please also 
put a proper patch message. I promise to be more responsive this time. :)

> 
> Good news is that disabling dat in batman-adv-2016.0 seems to solve my
> observed issues (in strange ways even the observed erroneous claim frames
> in the backbone network....). But I think dat is a clever feature to
> reduce broadcast load in the mesh network. Wouldn't it be useful to dig a
> little bit deeper into the combined use of dat and bla? I would volunteer
> for testing and providing ideas for improving the behaviour.

If you could help, that would be great! Your patch from last year already is a 
good start, so I'm sure you are capable of working on that. I would be happy 
to help with that, too.

> 
> Or do you think that I have an issue with my old 2.6.32 kernel?

I don't think so. To me it looks like the issue could still be present in 
current versions ...

Cheers,
     Simon
--nextPart2642916.lZ8J9AehcY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWvGupAAoJEKEr45hCkp6hjSYP/A91PvOv2YlShVDUT7Ui0iXR
ms7YKy37fJkAxrXFFyVW+AanEB1ln6V1G9Ex7/nwAsGlWzwwEiDc+5YwD8LX1IAQ
o3AbjPDldUwPdq0sUu451skBiAyek5pzOeQhG36pbGmN1rdQXNQj6sLpk+ikmQ3n
x2itsksWbp/LfVbD+U51VdGS/ILzwJiTgPBQGimEwDnR6HyPQUMVb/Ruw0g1ugsD
idld5UKYdUvuOBkujRPV5K59AVbN1Hg8+jC/kw5dQWV3smJqtHOQIar4B4oUbHol
Y43qgxK5ba80Qg+XefvH6z8NvwBsWyhq01ez7dXrGIFxpO36pN7TCXRWjkF6Iomr
gP/J/fLSAjcRYPDi0ozA6metY7XsJpNko2ZQYI9Aymdg+liKELC886FWlJ+HfyCw
w8Ua+C/zpbm2z0MSRsE8ZgZEtRQihHYQoYBAln49tM25uVQRGN9Xgo23OVOw7Cha
nU0tchBKYQ457lPNwoz0jgpjeFsGteuPFinvGaoLt1rjtFMi7hT58M5ZdgKAbkez
acgrWX4zQhXh02rrf755K4rDRa2kjsdnAXzH34W373w5Wk6RpwIfUUOGw9LJJvIV
/ZMFlsTZDQjewnMxtlR1rjsd2qQxNQk2gaKb9FsjtEUqHAQ5DmSuZgJNB/beSHR6
VlaTTSneLR5o6MPkepsX
=RQrq
-----END PGP SIGNATURE-----

--nextPart2642916.lZ8J9AehcY--

