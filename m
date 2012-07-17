Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Jul 2012 12:43:28 +0200
References: <1341524310-26740-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1341524310-26740-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207171243.28870.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/3] batman-adv: detect not yet
	announced clients
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Thursday, July 05, 2012 23:38:29 Antonio Quartulli wrote:
> With the current TT mechanism a new client joining the network is not
> immediately able to communicate with other hosts because its MAC address
> has not been announced yet. This situation holds until the first OGM
> containing its joining event will be spread over the mesh network.
> 
> This behaviour can be acceptable in networks where the originator interval
> is a small value (e.g. 1sec) but if that value is set to an higher time
> (e.g. 5secs) the client could suffer from several malfunctions like DHCP
> client timeouts, etc.
> 
> This patch adds an early detection mechanism that makes nodes in the
> network able to recognise "not yet announced clients" by means of the
> broadcast packets they emitted on connection (e.g. ARP or DHCP request).
> The added client will then be confirmed upon receiving the OGM claiming it
> or purged if such OGM is not received within a fixed amount of time.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> Changes since v4:
>  - roam_at was wrongly substituted by added_at in the ..global_to_purge()
>    function
> 
>  main.h              |    1 +
>  packet.h            |    1 +
>  translation-table.c |  125
> ++++++++++++++++++++++++++++++++++++++------------- translation-table.h
> |    4 +-
>  types.h             |    1 +
>  5 files changed, 100 insertions(+), 32 deletions(-)

Applied in revision 724d05c.

Thanks,
Marek
