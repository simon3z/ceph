Plain create with various options specified via usual cli arguments
===================================================================
  $ rbd create -s 1 test
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rb.0.*",  (glob)
      "format": 1, 
      "name": "test", 
      "object_size": 4194304, 
      "objects": 1, 
      "order": 22, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 --order 20 test
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rb.0.*",  (glob)
      "format": 1, 
      "name": "test", 
      "object_size": 1048576, 
      "objects": 1, 
      "order": 20, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --image-format 2
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 4194304, 
      "objects": 1, 
      "order": 22, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --image-format 2 --order 20
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 1048576, 
      "objects": 1, 
      "order": 20, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --image-format 2 --stripe-unit 1048576 --stripe-count 8
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 4194304, 
      "objects": 1, 
      "order": 22, 
      "size": 1048576, 
      "stripe_count": 8, 
      "stripe_unit": 1048576
  }
  $ rbd rm test --no-progress

Format 2 Usual arguments with custom rbd_default_* params
=========================================================
  $ rbd create -s 1 test --image-format 2 --stripe-unit 1048576 --stripe-count 8 --rbd-default-order 21
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 2097152, 
      "objects": 1, 
      "order": 21, 
      "size": 1048576, 
      "stripe_count": 8, 
      "stripe_unit": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --image-format 2 --stripe-unit 1048576 --stripe-count 8 --order 23 --rbd-default-order 20
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 8388608, 
      "objects": 1, 
      "order": 23, 
      "size": 1048576, 
      "stripe_count": 8, 
      "stripe_unit": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --image-format 2 --rbd-default-stripe-unit 1048576 --rbd-default-stripe-count 8
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 4194304, 
      "objects": 1, 
      "order": 22, 
      "size": 1048576, 
      "stripe_count": 8, 
      "stripe_unit": 1048576
  }
  $ rbd rm test --no-progress

Format 1 Usual arguments with custom rbd_default_* params
=========================================================
  $ rbd create -s 1 test --rbd-default-order 20
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rb.0.*",  (glob)
      "format": 1, 
      "name": "test", 
      "object_size": 1048576, 
      "objects": 1, 
      "order": 20, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --rbd-default-format 2
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 4194304, 
      "objects": 1, 
      "order": 22, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --rbd-default-format 2 --rbd-default-order 20
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 1048576, 
      "objects": 1, 
      "order": 20, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --rbd-default-format 2 --rbd-default-order 20 --rbd-default-features 1
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 1048576, 
      "objects": 1, 
      "order": 20, 
      "size": 1048576
  }
  $ rbd rm test --no-progress
  $ rbd create -s 1 test --rbd-default-format 2 --stripe-unit 1048576 --stripe-count 8
  $ rbd info test --format json | python -mjson.tool | sed 's/,$/, /'
  {
      "block_name_prefix": "rbd_data.*",  (glob)
      "features": [
          "layering", 
          "striping"
      ], 
      "format": 2, 
      "name": "test", 
      "object_size": 4194304, 
      "objects": 1, 
      "order": 22, 
      "size": 1048576, 
      "stripe_count": 8, 
      "stripe_unit": 1048576
  }
  $ rbd rm test --no-progress
