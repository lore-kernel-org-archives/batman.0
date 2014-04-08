Return-Path: <johannes@sipsolutions.net>
Message-ID: <1396951582.5936.20.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 08 Apr 2014 12:06:22 +0200
In-Reply-To: <1396211704-4677-7-git-send-email-antonio@meshcoding.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-7-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2 6/6] cfg80211: implement
 cfg80211_get_station cfg80211 API
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

On Sun, 2014-03-30 at 22:35 +0200, Antonio Quartulli wrote:

>  /**
> + * cfg80211_get_station - retrieve information about a given station
> + * @dev: the device where the station is supposed to be connected to
> + * @mac_addr: the mac address of the station of interest
> + * @sinfo: pointer to the structure to fill with the information
> + *
> + * Returns 0 on success or a negative error code otherwise.
> + */
> +int cfg80211_get_station(struct net_device *dev, u8 *mac_addr,
> +			 struct station_info *sinfo);

mac_addr should be const

Any thoughts about clearing/filling/partially filling *sinfo when
returning an error?

johannes

