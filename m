Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 09:52:57 +0800
References: <CAFevQmMNTep6A0-+0dCc4-qX3ty+Mo7EUFR4CE2WohgRdA3ZjA@mail.gmail.com>
In-Reply-To: <CAFevQmMNTep6A0-+0dCc4-qX3ty+Mo7EUFR4CE2WohgRdA3ZjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201301030952.57862.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] netifd batman-adv proto
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday, January 02, 2013 21:11:41 Filippo Sallemi wrote:
> I've writed a batman-adv proto in according on new netifd system of
> attitude adjustement release.
> With this script the batman-adv configuration could be moved on
> /etc/config/network file istead of /etc/config/batman-adv and the
> /lib/batman-adv/config.sh is no longer required.
> 
> es.
> 
> config interface mesh
>     option proto bat
>     option device bat0
>     option interfaces 'wlan0 wlan1'
>     option gw_mode server
>     ...
> 
> if someone think that my work could be useful and can provide a better
> and elegant integration on openwrt please keep in touch.

Can you explain the advantages of your approach compared to the netifd 
integration posted a couple of weeks ago ? I am not netifd expert therefore I 
am looking for the best way forward.

Thanks,
Marek
