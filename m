Return-Path: <duncan-tech-openmesh@404.978.org>
Message-ID: <97C5B1C7CD044FEDB67CC3C1E2055BDD@flightrisk>
From: "DuncanSF" <duncan-tech-openmesh@404.978.org>
References: <201009262057.36382.lindner_marek@yahoo.de><1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
	<201009261516.21774.lew.pitcher@digitalfreehold.ca>
In-Reply-To: <201009261516.21774.lew.pitcher@digitalfreehold.ca>
Date: Sun, 26 Sep 2010 17:25:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: softif lan loop avoidance
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

Sorry for the formatting: my client doesn't understand signed messages.

Lew quoted Marek who wrote:
> This patch adds the functionality to detect other batman-adv nodes
> connected to the LAN and select a 'gateway' to talk to the
> non-batman-adv devices on this LAN.

Doing this defeats part of the purpose of running batman-adv on
a LAN.  Picture the case where nodes have links between each
other both on their wireless interfaces and through Homeplug
adapters like the old Netgear XE102 Ethernet-to-Powerline bridge.

Electing a single mesh-to-LAN gateway as proposed will blackhole
any stations on that LAN unable to reach the elected gateway.

Not everything connected to a LAN port is a standard, reliable
local area network.  *smiles*

duncan.


----- Original Message ----- 
From: "Lew Pitcher" <lew.pitcher@digitalfreehold.ca>
To: "The list for a Better Approach To Mobile Ad-hoc Networking" 
<b.a.t.m.a.n@lists.open-mesh.org>
Sent: Sunday, September 26, 2010 12:16 PM
Subject: Re: [B.A.T.M.A.N.] batman-adv: softif lan loop avoidance


