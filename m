Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 2 Jun 2019 12:52:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH maint v2] batman-adv: Fix duplicated OGMs on NETDEV_UP
Message-ID: <20190602105241.GB2995@otheros>
References: <20190602095135.15604-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190602095135.15604-1-sven@narfation.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

On Sun, Jun 02, 2019 at 11:51:35AM +0200, Sven Eckelmann wrote:
> The state of slave interfaces are handled differently depending on whether
> the interface is up or not. All active interfaces (IFF_UP) will transmit
> OGMs. But for B.A.T.M.A.N. IV, also non-active interfaces are scheduling
> (low TTL) OGMs on active interfaces. The code which setups and schedules
> the OGMs must therefore already be called when the interfaces gets added as
> slave interface and the transmit function must then check whether it has to
> send out the OGM or not on the specific slave interface.
> 
> But the commit 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule
> API calls") moved the setup code from the enable function to the activate
> function. The latter is called either when the added slave was already up
> when batadv_hardif_enable_interface processed the new interface or when a
> NETDEV_UP event was received for this slave interfac. As result, each
> NETDEV_UP would schedule a new OGM worker for the interface and thus OGMs
> would be send a lot more than expected.
> 
> Fixes: 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule API calls")
> Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Tested-by: Linus Lüssing <linus.luessing@c0d3.blue>
