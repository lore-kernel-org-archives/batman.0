Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 04:28:46 +0800
References: <1350332596-23684-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1350332596-23684-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210160428.46880.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move hash_bytes into
	hash.h
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

On Tuesday, October 16, 2012 04:23:15 Simon Wunderlich wrote:
>  /**
> + *     batadv_hash_bytes - hash some bytes and add them to the previous
> hash + *     @hash: previous hash value
> + *     @data: data to be hashed
> + *     @size: number of bytes to be hashed
> + *
> + *     Returns 0 on success, 1 if the element already is in the hash
> + *     and -1 on error.
> + */
> +static inline void batadv_hash_bytes(uint32_t *hash, void *data, uint32_t
> size) +{
> +       const unsigned char *key = data;
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               *hash += key[i];
> +               *hash += (*hash << 10);
> +               *hash ^= (*hash >> 6);
> +       }
> +}

Seems the function lacks the documented return behavior ..  ;-)

Cheers,
Marek
