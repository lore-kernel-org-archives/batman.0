Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Apr 2010 17:57:36 +0800
References: <4BB70C4B.5000909@nord-west.org>
In-Reply-To: <4BB70C4B.5000909@nord-west.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201004031757.36408.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] running batman-adv in a openvz VE
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

On Saturday 03 April 2010 17:37:15 Bjoern Franke wrote:
> is there any possibility to run batman-adv in a openvz VE? Must it run
> as kernel module or is there any way to run it in userspace?

There was a userspace implementation but we abandoned this approach simply 
because it is too slow. Copying packets from userspace to kernelland and back 
is a real performance killer.

However, we are working towards supporting multiple mesh networks running on 
the same host which could solve your problem (I don't know openvz well enough 
to be 100% sure) but don't expect this feature very soon. It is work in 
progress. :-)

Cheers,
Marek
