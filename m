Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 8 May 2012 14:04:14 +0800
References: <4FA54C09.6000303@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
	<4FA7AD9B.2030604@universe-factory.net>
In-Reply-To: <4FA7AD9B.2030604@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205081404.14409.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
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

On Monday, May 07, 2012 19:10:19 Matthias Schiffer wrote:
> On 05/07/2012 08:40 AM, Marek Lindner wrote:
> > If you wish to replace the mac addresses with readable name you can
> > simply use a bat-hosts file to tell batctl which mac address should be
> > replaced. Check the bat-hosts section in our batctl online manpage:
> > http://downloads.open-mesh.org/batman/manpages/batctl.8.html
> 
> I know about bat-hosts, but this only works when the host displaying the
> data knows all the MAC address/hostname mappings. For community meshs
> like Freifunk networks it would be much nicer to allow each host to
> supply its own hostname for vis in my opinion. I think one possibility
> to add this without breaking compatiblity would be adding a hostname
> record after the neighbor entries in the vis packets.

Flooding the network with arbitrary data like hostnames, service 
announcements, weather info, etc comes up from time to time but it often boils 
down to the question: Why does it have to be in the kernel ? There are several 
ways to implement this feature in user space today without changing the kernel 
code.

Regards,
Marek
