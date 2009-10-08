Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 9 Oct 2009 03:39:17 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910090339.17577.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem - SOLVED
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> I have solved my problem.
> 
> It is related to the TCP checksum offload function: I am using as embedded
> platform PCEngines Alix 3d2, that do not support this function (and also
> qemu virtual machines do not support it).
> 
> This patch disable the tx checksum offload and everything now works fine
>  for me!

nice finding !
I looked through kernel source a bit and it seems we can live without that flag 
(the tun driver also does not set it). I would commit your patch to the 
repository unless there are objections ?

Regards,
Marek
