Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Sep 2010 11:33:21 +0200
References: <201009262057.36382.lindner_marek@yahoo.de>
	<201009271758.03620.lindner_marek@yahoo.de>
	<AANLkTinacNr1_eAFPiEhxx0ahPZ0_TRYYxKJZ617cFaH@mail.gmail.com>
In-Reply-To: <AANLkTinacNr1_eAFPiEhxx0ahPZ0_TRYYxKJZ617cFaH@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201009281133.21640.lindner_marek@yahoo.de>
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

On Monday 27 September 2010 23:00:21 Donald Gordon wrote:
> * Does this mean that batman will now send OGMs out the bat0 interface?

No, OGMs have to originate from the bridge interface bat0 belongs to.


> * Can the LAN be added as an interface that batman will send "normal"
> batman packets out, too?  So bat0 would be in a bridge br0 with e.g.
> eth0, but br0 or eth0 would also be set up as an interface batman
> would send/recieve batman-encapsulated packets on?

If an interface is part of a bridge (e.g. br0) it can't be used by batman-adv 
at the same time. The bridge module pulls in all the traffic. But that always 
has been the case and is not a new development.

Is that a theoretical question or do you have a use case ?


Regards,
Marek
