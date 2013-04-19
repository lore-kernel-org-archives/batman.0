Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Apr 2013 00:52:19 +0800
References: <1366387621-12718-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366387621-12718-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304200052.19401.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: change VID semantic in
	the BLA code
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <ordex@autistici.org>, Antonio Quartulli <antonio@open-mesh.com>

On Saturday, April 20, 2013 00:07:00 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> In order to make batman-adv fully vlan aware later, the
> semantic used for variables storing the VLAN ID values has
> to be changed in order to be adapted to the new one which
> will be used batman-adv wide.
> 
> In particular, the VID has to be an "_unsigned_ short int"
> and its 4 MSB will be used as a flag bitfield, while the
> remaining 12 bits are used to store the real VID value
> 
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> v3:
> - don't change the print format (keep %d)
> - added a couple of fixes to debug messages
> 
>  bridge_loop_avoidance.c | 50
> +++++++++++++++++++++++++------------------------ bridge_loop_avoidance.h
> | 12 +++++++-----
>  main.h                  | 11 +++++++++++
>  soft-interface.c        |  4 ++--
>  types.h                 |  4 ++--
>  5 files changed, 48 insertions(+), 33 deletions(-)

Applied in revision 0b1da17.

Thanks,
Marek
