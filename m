Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Dec 2011 17:26:40 +0800
References: <1323260777-30119-1-git-send-email-sven@narfation.org>
In-Reply-To: <1323260777-30119-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112081726.40642.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Allow to disable features
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

On Wednesday, December 07, 2011 20:29:11 Sven Eckelmann wrote:
> -# uncomment the CONFIG_* line to enable the related feature
> -# features enabled in the target kernel configuration cannot be disabled
> +# changing the CONFIG_* line to 'y' enables the related feature
>  # B.A.T.M.A.N. debugging:
> -# CONFIG_BATMAN_ADV_DEBUG=y
> +export CONFIG_BATMAN_ADV_DEBUG=n

Haven't tried it yet but does it mean the newly added 'activate this feature 
from the commandline' does not work anymore ?
For example: make CONFIG_BATMAN_ADV_DEBUG=y

Regards,
Marek
