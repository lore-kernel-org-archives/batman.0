Return-Path: <ordex@ritirata.org>
Date: Wed, 23 Feb 2011 09:54:09 +0100
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20110223085409.GA7707@ritirata.org>
References: <4D64BAFF.9050006@Radtke.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D64BAFF.9050006@Radtke.eu>
Subject: Re: [B.A.T.M.A.N.] Problem after configuring a bridge
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

Hello!

On mer, feb 23, 2011 at 08:45:03 +0100, Dr. Stefan Radtke wrote:
> I have to configure a bridge  (according to quick start guide 
> http://www.open-mesh.org/wiki/batman-adv-quick-start-guide) because I 
> want batman-adv to announce MAC-addresses connected to eth0 (see network 
> diagram):
> 
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
> ifconfig eth0 up
> ifconfig bat0 up
> ifconfig mesh-bridge up

Did you also do
	ifconfig bat0 0.0.0.0 up
	ifconfig mesh-bridge 192.168.10.2 u
?
You have to remove the IP address from the real interface and add it to
the bridge one.

Regards

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
