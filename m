Return-Path: <ordex@autistici.org>
Date: Mon, 4 Jul 2011 20:22:56 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110704182256.GB26734@autistici.org>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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

On Mon, Jul 04, 2011 at 06:06:19PM +0200, Max Ip wrote:
> Hi all,
> 
> This is something to be posted in other forums. But just wanted to
> know if you faced the same problem.
> 
> I tried to drop the connections between the end users (node_1 and node_3) of
> 
> node_1 ----node_2-----node_3
> 
> 
> iptables -t raw -A PREROUTING -i wlan0 -m mac --mac-source
> 00:13:a9:c3:ae:8f -j DROP
> 

This will not work because in this way you are blocking IP datagram with
source mac address equal to 00:13:a9:c3:ae:8f. Batman packets are not IP
datagram, so you can't block them by means of iptables.

As Marek suggested, you should use something like ebtables. But honestly I
remember that ebtables support has been removed from batman some time
ago.

Regards,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
