Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 12 Aug 2010 12:50:06 +0200
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008121233.46032.lindner_marek@yahoo.de>
	<AANLkTi=nX3JGXjpZRT9O5qf=TKMqxLWB+mazWAeD4wsF@mail.gmail.com>
In-Reply-To: <AANLkTi=nX3JGXjpZRT9O5qf=TKMqxLWB+mazWAeD4wsF@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008121250.07216.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Nat Question
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

On Thursday 12 August 2010 12:41:41 David Beaumont wrote:
> I originally had my MTU values set incorrectly, but believe i have
> them correct now
> 
> router with internet
> 
> ath0 - MTU 1524 (physical wifi device)
>
> router on otherside of mesh
>
> ath0 - MTU 1524 (physical wifi device)

Yes, that looks good. 
The problems you describe sound like MTU or firewall issues which is why I was 
asking.


> wifi0 - MTU 1500 (should this be 1524 also)

You should ignore the wifi0 interface and not include it in any configuration. 
It is of no relevance in your setup.


> I am aware that it is quite an old verison, although this is the
> version that is currently in the openwrt repo. I will compile a more
> recent version once i have the basics working i think.

Ok.


> Thanks for you help so far guys, two people have suggested MTU issues
> now, so fingers crossed someone can see something wrong with the
> output above?

Could you post the config of both nodes ? That includes:
* ifconfig
* brctl show
* ip route / route -n
* cat /proc/net/batman-adv/interfaces
* iptables (-t nat) -vnL [on the internet-router]

Regards,
Marek
