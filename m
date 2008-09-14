From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 14 Sep 2008 12:15:04 +0800
References: <20080912232420.GA9669@sven-desktop.lazhur.ath.cx>
In-Reply-To: <20080912232420.GA9669@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809141215.05216.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Make batman timer functions thread safe
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

On Saturday, 13. September 2008 07:24:20 Sven Eckelmann wrote:
> The calculation inside of update_internal_clock aren't atomic and can lead
> to bogus time informations when many threads calling get_time_msec64 or
> get_time_msec.

Just applied your latest patches as well. Thanks for looking over the code. 
Virgin eyes stumble easier over nasty stuff.  :-)

Greetings,
Marek
