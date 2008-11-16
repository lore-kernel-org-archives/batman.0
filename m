From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv debian announcement
Date: Mon, 17 Nov 2008 00:26:09 +0800
References: <200811170004.23285.lindner_marek@yahoo.de>
	<5635aa0d0811160806h69169967w846a18250d77b87c@mail.gmail.com>
In-Reply-To: <5635aa0d0811160806h69169967w846a18250d77b87c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811170026.10020.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Monday 17 November 2008 00:06:37 Outback Dingo wrote:
> any good docs on configuring batman-adv for atheros ?

We are writing it but it takes time.  :-)


Here the short intro:

Batman advanced is not aware of the Atheros driver. On every hardware it runs 
in the same way.

Load the module -> modprobe batman-adv-core

In /proc/net/batman-adv/ you will find the files to tweak batman. E.g. give it a 
device to operate on -> echo eth0 > /proc/net/batman-adv/interface

deactivate batman-adv -> echo "" > /proc/net/batman-adv/interface

The other files in that folder should be self explanatory. If not come back and 
ask us.

Regards,
Marek

