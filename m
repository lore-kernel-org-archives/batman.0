Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 5 Jan 2010 18:00:19 +0800
References: <201001042344.02273.lindner_marek@yahoo.de>
	<1262619976-5632-3-git-send-email-lindner_marek@yahoo.de>
	<20100105064349.GF9585@lunn.ch>
In-Reply-To: <20100105064349.GF9585@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001051800.19928.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: send DHCP requests
	directly to the chosen gw
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tuesday 05 January 2010 14:43:49 you wrote:
> Say the DHCP server is running in client mode. It has also been
> requested to broadcast its replies, not unicast the replies.
> 
> http://blogs.technet.com/teamdhcp/archive/2009/02/12/dhcp-broadcast-flag-ha
> ndling-in-windows-7.aspx
> 
> If i'm reading this code correctly, it will end up sending the DHCP
> reply messages by unicast to the best gateway, not the DHCP client?

I don't really get your question.
The batman-adv gwclient will encapsulate the DHCP discover / request packets 
in ethernet unicast headers instead of broadcast headers to make sure only the 
best gateway receives these broadcasts.
The server's replies won't be affected at all.

Regards,
Marek
