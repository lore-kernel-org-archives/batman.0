Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 6 Mar 2013 18:53:02 +0800
References: <1362565981-31117-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1362565981-31117-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303061853.03020.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: invoke post_func only if
	the attribute has been changed
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

On Wednesday, March 06, 2013 18:33:00 Antonio Quartulli wrote:
> @@ -169,7 +169,7 @@ __batadv_store_bool_attr(char *buff, size_t count,
>  
>         ret = batadv_store_bool_attr(buff, count, net_dev, attr->name,
>                                      attr_store);
> -       if (post_func && ret)
> +       if (post_func && ret > 0)
>                 post_func(net_dev);
>  
>         return ret;

If I remember correctly the shell or some other system between the kernel and 
userspace did not like to have 0 returned. It resulted in some funny "try to 
set this value over and over" reaction. You might want to test that.

Cheers,
Marek
