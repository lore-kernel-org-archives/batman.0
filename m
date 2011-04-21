Return-Path: <ordex@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Apr 2011 19:20:31 +0200
From: Antonio Quartulli <ordex@ritirata.org>
In-Reply-To: <BANLkTim9LrO298EnM8n63dcMZqC2Nh+6tg@mail.gmail.com>
References: <BANLkTimERe+ZVihn1SHbjubF84V2q2pANQ@mail.gmail.com>
	<BANLkTi=GP+EZAxPEZxEdO1yGwF-h6jVnMA@mail.gmail.com>
	<201104211835.35388.lindner_marek@yahoo.de>
	<BANLkTi=68rM5h-7eaVWRnSCiDZgzpKkHrA@mail.gmail.com>
	<BANLkTim9LrO298EnM8n63dcMZqC2Nh+6tg@mail.gmail.com>
Message-ID: <c2e82a568e15c598dc77382a109b3e20@autistici.org>
Subject: Re: [B.A.T.M.A.N.] Fwd: batman-adv multiple meshs
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

 On Thu, 21 Apr 2011 19:06:02 +0200, Gioacchino Mazzurco wrote:
> I see openwrt uci file you can define multiple mesh section, what
> happen if i define different mesh interfaces like bat0 and bat1 on
> every nodes?
>
> I will have 2 separated layer 2 networks?

 Yes, batman-adv provides this functionality. But iirc you cannot add 
 the
 same real device to more than one bat-interface.
 So, for example, eth0 can be added to bat0 but then you can't add it to 
 bat1

 If you really want to do this I think you can first split eth0 in 
 eth0:1 and
 eth0:2, as different vlans, and then add them to two different 
 bat-interfaces.

 Regards,

-- 
 Antonio Quartulli

 Ognuno di noi, da solo, non vale nulla
 Ernesto "Che" Guevara
