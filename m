Return-Path: <ditwal001@gmail.com>
From: "Walter Robert Ditzler" <ditwal001@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPQoTXbPAsVNnz8bVvWo0dwBAAAAAA==@gmail.com>
	<1981862.hQi2Ds3bj7@sven-desktop.home.narfation.org>
In-Reply-To: <1981862.hQi2Ds3bj7@sven-desktop.home.narfation.org>
Date: Thu, 21 Jun 2012 23:04:51 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPNW9mLDJApAt1pexLLy13MBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de-ch
Subject: Re: [B.A.T.M.A.N.] filling debian log
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
To: 'Sven Eckelmann' <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

hey Sven,

thanks, yes it ist he ath5 driver, read some stuff online about it, just
noone tells how to stop it.

in case i will not find a solution soon i will just do:

cd /var/log
for i in *
  do test -f $i -a -s $i && > $i
done

thanks walter.



-----Original Message-----
From: Sven Eckelmann [mailto:sven@narfation.org] 
Sent: Donnerstag, 21. Juni 2012 22:48
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Walter Robert Ditzler
Subject: Re: [B.A.T.M.A.N.] filling debian log

On Thursday 21 June 2012 22:44:41 Walter Robert Ditzler wrote:
> how are you today? i just ran into a minor problem with my flashybrid 
> box, debian 6.0.5, batman-adv 2012.1. batman-adv fills up my logs!
> 
> anyone here who knows how to stop loggin or perhaps only "never to 
> miss stuff"?
> 
> i tried to set "batctl loglevel none" but with no help in fact.
> 
> anyway, your help are appreciated :-)

THis is not batman-adv... this is your wlan-whatever driver. Could this be a
bcm43xx?

Kind regards,
	Sven

