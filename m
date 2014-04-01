Return-Path: <gio@eigenlab.org>
From: Gioacchino Mazzurco <gio@eigenlab.org>
Date: Tue, 01 Apr 2014 12:35:39 +0200
Message-ID: <1732522.mMifORosKp@vaio-gio>
In-Reply-To: <web-133442820@sns.it>
References: <5339CBBD.9050708@sns.it> <web-133442820@sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] br-lan: received packet on bat0 with own address
	as source address
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

On Tuesday 01 April 2014 11:33:01 Ilario GELMETTI wrote:
> I tried changing the mac address
> config interface 'lm_eth0_batadv'
>         option ifname 'eth0.11'
>         option proto 'batadv'
>         option mesh 'bat0'
>         option mtu '1496'
>         option macaddr 'dc:9f:db:31:c1:38'
> and that error in dmesg went away.

Why a packet form eth0.11 should arrive periodically to the bridge ?
Someone can make some sense out of this ?
